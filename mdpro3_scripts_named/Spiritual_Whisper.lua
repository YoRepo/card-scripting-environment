--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 耳语灵仪鸟  (ID: 50155385)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 200 | DEF 2000
--
-- Effect Text:
-- ①：这张卡1回合只有1次不会被战斗破坏。
-- ②：这张卡灵摆召唤成功时才能发动。从卡组把1只仪式怪兽或者1张仪式魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--スピリチューアル・ウィスパー
function c50155385.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c50155385.valcon)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50155385,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c50155385.thcon)
	e2:SetTarget(c50155385.thtg)
	e2:SetOperation(c50155385.thop)
	c:RegisterEffect(e2)
end
function c50155385.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c50155385.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c50155385.filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c50155385.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50155385.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c50155385.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c50155385.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
