--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 冰水艇 翡翠灵翠鸟  (ID: 66749546)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 9
-- ATK 2500 | DEF 2500
-- Setcode: 364
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：以自己场上1只水属性怪兽为对象才能发动。从自己的手卡·场上把这张卡当作装备卡使用给那只怪兽装备。
-- ②：有这张卡装备的「冰水」怪兽可以用守备表示的状态作出攻击。那个场合，装备怪兽用守备力当作攻击力使用进行伤害计算。
-- ③：以持有装备怪兽的守备力以下的攻击力的对方场上1只怪兽为对象才能发动。这张卡特殊召唤，作为对象的怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--氷水艇キングフィッシャー
function c66749546.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66749546,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c66749546.eqtg)
	e1:SetOperation(c66749546.eqop)
	c:RegisterEffect(e1)
	--defense attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_DEFENSE_ATTACK)
	e2:SetCondition(c66749546.dacon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--unequip
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,66749546)
	e3:SetTarget(c66749546.sptg)
	e3:SetOperation(c66749546.spop)
	c:RegisterEffect(e3)
end
function c66749546.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c66749546.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c66749546.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and e:GetHandler():CheckUniqueOnField(tp)
		and Duel.IsExistingTarget(c66749546.filter,tp,LOCATION_MZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c66749546.filter,tp,LOCATION_MZONE,0,1,1,c)
end
function c66749546.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsControler(1-tp) or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c66749546.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c66749546.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c66749546.dacon(e,ctp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsSetCard(0x16c)
end
function c66749546.spfilter(c,def)
	return c:IsFaceup() and c:IsAttackBelow(def) and c:IsAbleToHand()
end
function c66749546.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if chk==0 then return ec and ec:IsDefenseAbove(0)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c66749546.spfilter,tp,0,LOCATION_MZONE,1,nil,ec:GetDefense()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c66749546.spfilter,tp,0,LOCATION_MZONE,1,1,nil,ec:GetDefense())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c66749546.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
