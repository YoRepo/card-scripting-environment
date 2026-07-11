--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Tsukuyomi  (ID: 34853266)
-- Type: Monster / Effect / Spirit
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1100 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- If this card is Normal Summoned or flipped face-up: Target 1 face-up monster on the field; change
-- that target to face-down Defense Position.
-- Once per turn, during the End Phase, if this card was Normal Summoned or flipped face-up this turn:
-- Return it to the hand.
--[[ __CARD_HEADER_END__ ]]

--月読命
function c34853266.initial_effect(c)
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
	e4:SetDescription(aux.Stringid(34853266,1))
	e4:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c34853266.postg)
	e4:SetOperation(c34853266.posop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
end
function c34853266.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c34853266.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c34853266.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c34853266.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c34853266.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
