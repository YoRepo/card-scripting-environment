--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 破坏剑-龙破坏之剑  (ID: 76218313)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level 1
-- ATK 400 | DEF 300
-- Setcode: 214
--
-- Effect Text:
-- 「破坏剑-龙破坏之剑」的③的效果1回合只能使用1次。
-- ①：自己主要阶段以自己场上1只「破坏之剑士」为对象才能发动。从自己的手卡·场上把这只怪兽当作装备卡使用给那只自己怪兽装备。
-- ②：这张卡装备中的场合，对方不能从额外卡组把怪兽特殊召唤。
-- ③：这张卡装备中的场合才能发动。装备的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--破壊剣－ドラゴンバスターブレード
function c76218313.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c76218313.eqtg)
	e1:SetOperation(c76218313.eqop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c76218313.effcon)
	e2:SetTarget(c76218313.splimit)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,76218313)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c76218313.spcon)
	e3:SetTarget(c76218313.sptg)
	e3:SetOperation(c76218313.spop)
	c:RegisterEffect(e3)
end
function c76218313.filter(c)
	return c:IsFaceup() and c:IsCode(78193831)
end
function c76218313.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c76218313.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c76218313.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c76218313.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c76218313.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsControler(1-tp) or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c76218313.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c76218313.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c76218313.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()
end
function c76218313.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c76218313.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c76218313.effcon(e)
	return e:GetHandler():GetEquipTarget()
end
function c76218313.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA)
end
