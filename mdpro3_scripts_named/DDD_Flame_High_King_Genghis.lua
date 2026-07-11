--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: D/D/D Flame High King Genghis  (ID: 16006416)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Fiend
-- Level: 8
-- ATK 2800 | DEF 2400
-- Setcode: 0x10af
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Level 5 or higher "D/D" monster + 1 "D/D" monster
-- If another "D/D" monster(s) is Normal or Special Summoned to your field while you control this
-- monster (except during the Damage Step): You can target 1 "D/D" monster in your GY; Special Summon
-- it.
-- You can only use this effect of "D/D/D Flame High King Genghis" once per turn.
-- Once per your turn, when a Spell/Trap Card, or its effect, is activated (Quick Effect): You can
-- negate the activation.
--[[ __CARD_HEADER_END__ ]]

--DDD烈火大王エグゼクティブ・テムジン
function c16006416.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c16006416.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0xaf),true)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16006416,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,16006416)
	e1:SetCondition(c16006416.spcon)
	e1:SetTarget(c16006416.sptg)
	e1:SetOperation(c16006416.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(16006416,1))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c16006416.negcon)
	e3:SetTarget(c16006416.negtg)
	e3:SetOperation(c16006416.negop)
	c:RegisterEffect(e3)
end
function c16006416.matfilter(c)
	return c:IsFusionSetCard(0xaf) and c:IsLevelAbove(5)
end
function c16006416.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xaf) and c:IsControler(tp)
end
function c16006416.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c16006416.cfilter,1,nil,tp)
end
function c16006416.spfilter(c,e,tp)
	return c:IsSetCard(0xaf) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c16006416.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c16006416.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c16006416.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c16006416.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c16006416.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c16006416.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function c16006416.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c16006416.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
