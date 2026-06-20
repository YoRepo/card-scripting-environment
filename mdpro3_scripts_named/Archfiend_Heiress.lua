--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 诡计恶魔  (ID: 66540884)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1000 | DEF 0
-- Setcode: 69
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡被效果送去墓地的场合或者被战斗破坏送去墓地的场合才能发动。从卡组把「诡计恶魔」以外的1张「恶魔」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--トリック・デーモン
function c66540884.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66540884,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,66540884)
	e1:SetCondition(c66540884.thcon)
	e1:SetTarget(c66540884.thtg)
	e1:SetOperation(c66540884.thop)
	c:RegisterEffect(e1)
end
function c66540884.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) or c:IsReason(REASON_BATTLE)
end
function c66540884.thfilter(c)
	return c:IsSetCard(0x45) and not c:IsCode(66540884) and c:IsAbleToHand()
end
function c66540884.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66540884.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c66540884.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c66540884.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
