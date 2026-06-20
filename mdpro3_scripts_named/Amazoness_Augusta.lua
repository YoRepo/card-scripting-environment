--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 亚马逊女帝王  (ID: 23965033)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 10
-- ATK 3200 | DEF 2800
-- Setcode: 4
--
-- Effect Text:
-- 「亚马逊」融合怪兽＋「亚马逊」怪兽
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡融合召唤成功的场合才能发动。从卡组把1只「亚马逊」怪兽特殊召唤。
-- ②：只要这张卡在怪兽区域存在，这张卡以外的自己场上的「亚马逊」卡不会成为对方的效果的对象，不会被对方的效果破坏。
-- ③：「亚马逊女帝」或者「亚马逊女王」为素材作融合召唤的这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--アマゾネス女帝王
function c23965033.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c23965033.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0x4),true)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23965033,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,23965033)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c23965033.spcon)
	e1:SetTarget(c23965033.sptg)
	e1:SetOperation(c23965033.spop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c23965033.indtg)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(c23965033.indtg)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--multi attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c23965033.condition)
	e4:SetOperation(c23965033.operation)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_MATERIAL_CHECK)
	e5:SetValue(c23965033.valcheck)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
function c23965033.matfilter(c)
	return c:IsFusionType(TYPE_FUSION) and c:IsFusionSetCard(0x4)
end
function c23965033.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c23965033.spfilter(c,e,tp)
	return c:IsSetCard(0x4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23965033.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23965033.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23965033.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23965033.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c23965033.indtg(e,c)
	return c:IsSetCard(0x4) and c~=e:GetHandler()
end
function c23965033.valcheck(e,c)
	e:GetLabelObject():SetLabel(c:GetMaterial():FilterCount(Card.IsCode,nil,4591250,15951532))
end
function c23965033.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c23965033.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	if ct>=1 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(23965033,1))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end
