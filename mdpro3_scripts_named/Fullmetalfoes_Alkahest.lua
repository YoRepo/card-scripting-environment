--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 重炼装勇士·万溶炼金师  (ID: 77693536)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Psychic
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 225
--
-- Effect Text:
-- 「炼装」怪兽＋通常怪兽
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：对方回合1次，以场上1只效果怪兽为对象才能发动。那只效果怪兽当作装备卡使用给这张卡装备。
-- ②：这张卡的守备力上升这张卡的效果装备的怪兽的原本攻击力数值。
-- ③：这张卡有由「炼装」融合怪兽卡决定的融合素材怪兽装备的场合，可以把那装备卡作为那只融合怪兽的融合素材使用。
--[[ __CARD_HEADER_END__ ]]

--フルメタルフォーゼ・アルカエスト
function c77693536.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xe1),aux.FilterBoolFunction(Card.IsFusionType,TYPE_NORMAL),true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77693536,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c77693536.eqcon)
	e2:SetTarget(c77693536.eqtg)
	e2:SetOperation(c77693536.eqop)
	c:RegisterEffect(e2)
	--equip fusion material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_EXTRA_FUSION_MATERIAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_SZONE,0)
	e3:SetTarget(c77693536.mttg)
	e3:SetValue(c77693536.mtval)
	c:RegisterEffect(e3)
end
function c77693536.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c77693536.eqfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
		and (c:IsControler(tp) or c:IsAbleToChangeControler())
end
function c77693536.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c77693536.eqfilter(chkc,tp) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c77693536.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c77693536.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c77693536.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsType(TYPE_EFFECT)) then return end
	local atk=tc:GetTextAttack()
	if atk<0 then atk=0 end
	if not Duel.Equip(tp,tc,c) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_OWNER_RELATE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetValue(c77693536.eqlimit)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e2)
end
function c77693536.eqlimit(e,c)
	return e:GetOwner()==c
end
function c77693536.mttg(e,c)
	return c:GetEquipTarget()==e:GetHandler() and c:GetOriginalType()&TYPE_MONSTER~=0
end
function c77693536.mtval(e,c)
	if not c then return false end
	return c:IsSetCard(0xe1)
end
