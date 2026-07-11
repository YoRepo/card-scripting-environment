--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ojama Emperor  (ID: 34031284)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Beast
-- Link Rating: 3
-- Link Arrows: Bottom-Left, Bottom, Bottom-Right
-- ATK 0
-- Setcode: 0xf
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Beast monsters, including an "Ojama" monster
-- While "Ojama Country" is in a Field Zone, this card gains 3000 ATK, also it cannot be destroyed by
-- card effects.
-- Your opponent takes any battle damage you would have taken from attacks on this card, instead.
-- You can target 1 non-Link "Ojama" monster in your GY; Special Summon it, also for the rest of this
-- turn, you cannot Special Summon monsters from the Extra Deck, except Fusion Monsters.
-- You can only use this effect of "Ojama Emperor" once per turn.
--[[ __CARD_HEADER_END__ ]]

--おジャマ・エンペラー
function c34031284.initial_effect(c)
	aux.AddCodeList(c,90011152)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_BEAST),3,3,c34031284.lcheck)
	c:EnableReviveLimit()
	--atk & indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c34031284.condition)
	e1:SetValue(3000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--reflect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e3:SetCondition(c34031284.refcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(34031284,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,34031284)
	e4:SetTarget(c34031284.target)
	e4:SetOperation(c34031284.operation)
	c:RegisterEffect(e4)
end
function c34031284.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0xf)
end
function c34031284.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(90011152,PLAYER_ALL,LOCATION_FZONE)
end
function c34031284.refcon(e)
	return Duel.GetAttackTarget()==e:GetHandler()
end
function c34031284.filter(c,e,tp)
	return c:IsSetCard(0xf) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_LINK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c34031284.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c34031284.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c34031284.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c34031284.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c34031284.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c34031284.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c34031284.splimit(e,c)
	return not c:IsType(TYPE_FUSION) and c:IsLocation(LOCATION_EXTRA)
end
