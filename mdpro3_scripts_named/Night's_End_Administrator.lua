--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Night's End Administrator  (ID: 3779493)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 6
-- ATK 2300 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Night's End Sorcerer" + 1+ non-Tuner monsters
-- If this card is Special Summoned, or if another Spellcaster monster(s) is Special Summoned to your
-- field: You can target 1 card in your opponent's GY; banish it.
-- If this card is destroyed by battle, or if this card in its owner's Monster Zone is destroyed by an
-- opponent's card effect: You can target 1 Level 4 or lower Spellcaster monster in your GY; Special
-- Summon it.
-- You can only use this effect of "Night's End Administrator" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ナイトエンド・アドミニストレーター
function c3779493.initial_effect(c)
	aux.AddMaterialCodeList(c,36107810)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,36107810),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3779493,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c3779493.target)
	e1:SetOperation(c3779493.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c3779493.condition)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3779493,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,3779493)
	e3:SetCondition(c3779493.spcon)
	e3:SetTarget(c3779493.sptg)
	e3:SetOperation(c3779493.spop)
	c:RegisterEffect(e3)
end
function c3779493.cfilter(c,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsFaceup() and c:IsControler(tp)
end
function c3779493.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c3779493.cfilter,1,e:GetHandler(),tp)
end
function c3779493.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c3779493.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c3779493.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and (rp~=tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp) or c:IsReason(REASON_BATTLE))
end
function c3779493.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3779493.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c3779493.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c3779493.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c3779493.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c3779493.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
