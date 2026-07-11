--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Tsuru-Puru-Purun  (ID: 84635192)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 2
-- ATK 450 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your hand: You can target 1 WATER monster in your Main Monster Zone; destroy that
-- monster you control, and if you do, Special Summon this card to the zone that monster was in, then
-- you can destroy all face-up cards your opponent controls in this card's column.
-- You can only use this effect of "Tsuru-Puru-Purun" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ツルプルプルン
local s,id,o=GetID()
function s.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
function s.filter(c,e,tp)
	local seq=c:GetSequence()
	return seq<5 and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_TOFIELD,1<<seq)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local seq=tc:GetSequence()
	if tc:IsControler(tp) and tc:IsType(TYPE_MONSTER) and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0
		and c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,1<<seq)~=0 then
		Duel.AdjustAll()
		local g=c:GetColumnGroup():Filter(aux.AND(Card.IsFaceup,Card.IsControler),nil,1-tp)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			Duel.BreakEffect()
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
