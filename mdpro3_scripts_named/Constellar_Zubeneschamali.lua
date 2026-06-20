--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 星圣·氐宿四  (ID: 14759024)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 5
-- ATK 2100 | DEF 1400
-- Setcode: 83
--
-- Effect Text:
-- 这张卡召唤·特殊召唤成功时，可以从自己卡组把1只名字带有「星圣」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・エスカ
function c14759024.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14759024,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c14759024.tg)
	e1:SetOperation(c14759024.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	c:RegisterEffect(e2)
	c14759024.star_knight_summon_effect=e1
end
function c14759024.filter(c)
	return c:IsSetCard(0x53) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c14759024.tg(e,tp,eg,ep,ev,re,r,rp,chk,_,exc)
	if chk==0 then return Duel.IsExistingMatchingCard(c14759024.filter,tp,LOCATION_DECK,0,1,exc) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c14759024.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c14759024.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
