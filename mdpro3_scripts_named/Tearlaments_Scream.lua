--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 劈穿壹世坏的弦声  (ID: 6767771)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 385
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：场上有怪兽召唤·特殊召唤的场合，若自己场上有「珠泪哀歌族」怪兽或者「维萨斯-斯塔弗罗斯特」存在则能发动。从自己卡组上面把3张卡送去墓地。这个回合，对方场上的怪兽的攻击力下降500。
-- ②：这张卡被效果送去墓地的场合才能发动。从卡组把1张「珠泪哀歌族」陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--壱世壊を劈く弦声
function c6767771.initial_effect(c)
	aux.AddCodeList(c,56099748)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_ACTIVATE_CONDITION)
	e2:SetCountLimit(1,6767771)
	e2:SetCondition(c6767771.discon)
	e2:SetTarget(c6767771.distg)
	e2:SetOperation(c6767771.disop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,6767772)
	e4:SetCondition(c6767771.thcon)
	e4:SetTarget(c6767771.thtg)
	e4:SetOperation(c6767771.thop)
	c:RegisterEffect(e4)
end
function c6767771.disfilter(c)
	return ((c:IsSetCard(0x181) and c:IsLocation(LOCATION_MZONE)) or c:IsCode(56099748)) and c:IsFaceup()
end
function c6767771.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c6767771.disfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c6767771.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c6767771.disop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-500)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c6767771.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c6767771.thfilter(c)
	return c:IsSetCard(0x181) and c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c6767771.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6767771.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6767771.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6767771.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
