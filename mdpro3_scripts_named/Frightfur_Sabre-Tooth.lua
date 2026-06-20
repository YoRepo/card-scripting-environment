--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔玩具·军刀剑齿虎  (ID: 80889750)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2400 | DEF 2000
-- Setcode: 173
--
-- Effect Text:
-- 「魔玩具」融合怪兽＋「毛绒动物」怪兽或者「锋利小鬼」怪兽1只以上
-- ①：这张卡融合召唤成功时，以自己墓地1只「魔玩具」怪兽为对象才能发动。那只怪兽特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己场上的「魔玩具」怪兽的攻击力上升400。
-- ③：怪兽3只以上为素材作融合召唤的这张卡不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--デストーイ・サーベル・タイガー
function c80889750.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,c80889750.mfilter1,c80889750.mfilter2,1,127,true)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c80889750.spcon)
	e2:SetTarget(c80889750.sptg)
	e2:SetOperation(c80889750.spop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xad))
	e3:SetValue(400)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c80889750.indcon)
	e4:SetOperation(c80889750.indop)
	c:RegisterEffect(e4)
end
function c80889750.mfilter1(c)
	return c:IsFusionSetCard(0xad) and c:IsFusionType(TYPE_FUSION)
end
function c80889750.mfilter2(c)
	return c:IsFusionSetCard(0xa9,0xc3)
end
function c80889750.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c80889750.spfilter(c,e,tp)
	return c:IsSetCard(0xad) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80889750.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c80889750.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c80889750.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c80889750.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c80889750.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c80889750.indcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_FUSION) and c:GetMaterialCount()>=3
end
function c80889750.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(80889750,0))
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	c:RegisterEffect(e2)
end
