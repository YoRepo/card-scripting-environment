--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Otohime  (ID: 39751093)
-- Type: Monster / Effect / Spirit
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 3
-- ATK 0 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- During the End Phase of the turn this card is Normal Summoned or flipped face-up: Return it to the
-- hand.
-- When this card is Normal Summoned or flipped face-up: You can target 1 face-up monster your opponent
-- controls; change that target's battle position.
--[[ __CARD_HEADER_END__ ]]

--竜宮之姫
function c39751093.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--pos
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(39751093,1))
	e4:SetCategory(CATEGORY_POSITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c39751093.target)
	e4:SetOperation(c39751093.operation)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
end
function c39751093.filter(c)
	return c:IsFaceup() and c:IsCanChangePosition()
end
function c39751093.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c39751093.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c39751093.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c39751093.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c39751093.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
