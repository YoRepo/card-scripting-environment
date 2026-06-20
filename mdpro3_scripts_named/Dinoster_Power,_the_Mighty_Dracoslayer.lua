--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 刚龙剑士 雾动星·强力  (ID: 22638495)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Dragon
-- Level 8
-- ATK 2000 | DEF 2950
-- Setcode: 199
--
-- Effect Text:
-- 「龙剑士」灵摆怪兽＋灵摆怪兽
-- 把自己场上的上记卡解放的场合才能从额外卡组特殊召唤（不需要「融合」）。
-- ①：只要这张卡在怪兽区域存在，自己的怪兽区域·灵摆区域的灵摆怪兽卡不会被战斗以及对方的效果破坏。
-- ②：1回合1次，自己主要阶段才能发动。从自己的手卡·墓地选1只「龙剑士」灵摆怪兽特殊召唤。这个效果特殊召唤的怪兽不能作为融合素材。
--[[ __CARD_HEADER_END__ ]]

--剛竜剣士ダイナスターP
function c22638495.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_PENDULUM),aux.AND(aux.FilterBoolFunction(Card.IsFusionType,TYPE_PENDULUM),aux.FilterBoolFunction(Card.IsFusionSetCard,0xc7)),false)
	aux.AddContactFusionProcedure(c,aux.FilterBoolFunction(Card.IsReleasable,REASON_SPSUMMON),LOCATION_MZONE,0,Duel.Release,REASON_SPSUMMON+REASON_MATERIAL)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c22638495.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c22638495.sptg)
	e3:SetOperation(c22638495.spop2)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE+LOCATION_PZONE,0)
	e4:SetTarget(c22638495.indtg)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(LOCATION_MZONE+LOCATION_PZONE,0)
	e5:SetTarget(c22638495.indtg)
	e5:SetValue(aux.tgoval)
	c:RegisterEffect(e5)
end
function c22638495.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c22638495.spfilter(c,e,tp)
	return c:IsSetCard(0xc7) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22638495.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22638495.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c22638495.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c22638495.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c22638495.indtg(e,c)
	return c:IsType(TYPE_PENDULUM)
end
