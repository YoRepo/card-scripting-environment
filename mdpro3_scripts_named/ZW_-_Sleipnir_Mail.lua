--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 异热同心武器-极星神马圣铠  (ID: 2648201)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 4222
--
-- Effect Text:
-- ①：「异热同心武器-极星神马圣铠」在自己场上只能有1张表侧表示存在。
-- ②：以自己场上1只「希望皇 霍普」怪兽为对象才能发动。从自己的手卡·场上把这张卡当作攻击力上升1000的装备卡使用给那只自己的「希望皇 霍普」怪兽装备。
-- ③：装备怪兽被对方破坏让这张卡被送去墓地时，以自己墓地1只「希望皇 霍普」怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ZW－極星神馬聖鎧
function c2648201.initial_effect(c)
	c:SetUniqueOnField(1,0,2648201)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2648201,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCondition(c2648201.eqcon)
	e1:SetTarget(c2648201.eqtg)
	e1:SetOperation(c2648201.eqop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2648201,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c2648201.spcon)
	e2:SetTarget(c2648201.sptg)
	e2:SetOperation(c2648201.spop)
	c:RegisterEffect(e2)
end
function c2648201.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():CheckUniqueOnField(tp)
end
function c2648201.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c2648201.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c2648201.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c2648201.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c2648201.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2648201.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsControler(1-tp) or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	c2648201.zw_equip_monster(c,tp,tc)
end
function c2648201.zw_equip_monster(c,tp,tc)
	if not Duel.Equip(tp,c,tc) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c2648201.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
end
function c2648201.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c2648201.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	return c:IsReason(REASON_LOST_TARGET) and c:IsPreviousControler(tp) and ec:IsReason(REASON_DESTROY) and ec:GetReasonPlayer()==1-tp
end
function c2648201.spfilter(c,e,tp)
	return c:IsSetCard(0x107f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c2648201.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c2648201.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c2648201.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c2648201.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c2648201.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
