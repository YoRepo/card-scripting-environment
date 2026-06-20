--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 变形斗士·显微镜  (ID: 10591919)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 3
-- ATK 800 | DEF 1400
-- Setcode: 38
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：1回合1次，可以从手卡把1只4星的名字带有「变形斗士」的怪兽特殊召唤。这个效果特殊召唤的怪兽在结束阶段时破坏。
-- ●守备表示：只要这张卡在场上表侧守备表示存在，这张卡的等级变成4星。
--[[ __CARD_HEADER_END__ ]]

--D・スコープン
function c10591919.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10591919,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c10591919.cona)
	e1:SetTarget(c10591919.tga)
	e1:SetOperation(c10591919.opa)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_LEVEL)
	e2:SetCondition(c10591919.cond)
	e2:SetValue(4)
	c:RegisterEffect(e2)
end
function c10591919.filter(c,e,tp)
	return c:IsSetCard(0x26) and c:IsLevel(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10591919.cona(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDisabled() and e:GetHandler():IsAttackPos()
end
function c10591919.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10591919.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c10591919.opa(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10591919.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	local fid=e:GetHandler():GetFieldID()
	tc:RegisterFlagEffect(10591919,RESET_EVENT+RESETS_STANDARD,0,1,fid)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetLabel(fid)
	e1:SetLabelObject(tc)
	e1:SetCondition(c10591919.descon)
	e1:SetOperation(c10591919.desop)
	Duel.RegisterEffect(e1,tp)
end
function c10591919.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(10591919)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c10591919.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetLabelObject(),REASON_EFFECT)
end
function c10591919.cond(e)
	return e:GetHandler():IsDefensePos()
end
