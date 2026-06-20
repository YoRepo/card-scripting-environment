--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 教导的天启 阿东  (ID: 33296432)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 325
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：从额外卡组特殊召唤的怪兽在场上存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡不会被和从额外卡组特殊召唤的怪兽的战斗破坏。
-- ③：场上的这张卡被战斗·效果破坏的场合才能发动。从卡组把「教导的天启 阿东」以外的1只「教导」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--教導の天啓アディン
function c33296432.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33296432,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,33296432)
	e1:SetCondition(c33296432.spcon)
	e1:SetTarget(c33296432.sptg)
	e1:SetOperation(c33296432.spop)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c33296432.indes)
	c:RegisterEffect(e2)
	--spsummon2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33296432,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,33296433)
	e3:SetCondition(c33296432.spcon2)
	e3:SetTarget(c33296432.sptg2)
	e3:SetOperation(c33296432.spop2)
	c:RegisterEffect(e3)
end
function c33296432.cfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c33296432.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c33296432.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c33296432.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33296432.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c33296432.indes(e,c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c33296432.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c33296432.spfilter(c,e,tp)
	return c:IsSetCard(0x145) and not c:IsCode(33296432) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33296432.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33296432.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c33296432.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c33296432.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
