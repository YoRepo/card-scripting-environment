--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Heavy Mech Support Armor  (ID: 39890958)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level: 3
-- ATK 500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal Summoned: You can target 1 Union monster in your GY; Special Summon it.
-- Once per turn, you can either: Target 1 Machine monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- Your opponent cannot target a monster equipped with this card with card effects, also if the
-- equipped monster would be destroyed by battle or card effect, destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--強化支援メカ・ヘビーアーマー
function c39890958.initial_effect(c)
	aux.EnableUnionAttribute(c,c39890958.filter)
	--untargetable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(39890958,2))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetTarget(c39890958.sumtg)
	e5:SetOperation(c39890958.sumop)
	c:RegisterEffect(e5)
end
c39890958.has_text_type=TYPE_UNION
function c39890958.filter(c)
	return c:IsRace(RACE_MACHINE)
end
function c39890958.spfilter(c,e,tp)
	return c:IsType(TYPE_UNION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c39890958.sumtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39890958.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c39890958.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c39890958.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c39890958.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
