--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 强求哥布林  (ID: 12152769)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 4
-- ATK 1000 | DEF 2000
-- Setcode: 172
--
-- Effect Text:
-- ①：这张卡给与对方战斗伤害的场合发动。对方可以把1张手卡交给这张卡的控制者让这个效果无效。没交的场合，自己从卡组把1张「哥布林」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--おねだりゴブリン
function c12152769.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12152769,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c12152769.condition)
	e1:SetTarget(c12152769.target)
	e1:SetOperation(c12152769.operation)
	c:RegisterEffect(e1)
end
function c12152769.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c12152769.filter(c)
	return c:IsSetCard(0xac) and c:IsAbleToHand()
end
function c12152769.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c12152769.operation(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	if Duel.IsChainDisablable(0) and hg:GetCount()>0
		and Duel.SelectYesNo(1-tp,aux.Stringid(12152769,1)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(12152769,2))
		local sg=hg:Select(1-tp,1,1,nil)
		Duel.SendtoHand(sg,tp,REASON_EFFECT)
		Duel.NegateEffect(0)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c12152769.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
