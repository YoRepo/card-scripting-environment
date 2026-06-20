--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 海造贼-象征  (ID: 80621422)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 319
--
-- Effect Text:
-- 「海造贼」怪兽才能装备。这个卡名的②的效果1回合只能使用1次。
-- ①：装备怪兽的攻击力上升500，不会成为对方的效果的对象。
-- ②：把装备的这张卡送去墓地才能发动。把持有和双方的场上·墓地的怪兽的其中任意种相同属性的1只「海造贼」怪兽从额外卡组特殊召唤。那之后，这张卡装备过的怪兽给那只特殊召唤的怪兽当作攻击力上升500的装备卡
-- 使用来装备。
--[[ __CARD_HEADER_END__ ]]

--海造賊－象徴
function c80621422.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c80621422.target)
	e1:SetOperation(c80621422.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c80621422.eqlimit)
	c:RegisterEffect(e2)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(500)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(80621422,1))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1,80621422)
	e5:SetCost(c80621422.spcost)
	e5:SetTarget(c80621422.sptg)
	e5:SetOperation(c80621422.spop)
	c:RegisterEffect(e5)
end
function c80621422.eqfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x13f)
end
function c80621422.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c80621422.eqfilter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80621422.eqfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c80621422.eqfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c80621422.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and c:CheckUniqueOnField(tp) then
		Duel.Equip(tp,c,tc)
	end
end
function c80621422.eqlimit(e,c)
	return c:IsSetCard(0x13f)
end
function c80621422.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabelObject(e:GetHandler():GetEquipTarget())
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c80621422.spfilter(c,e,tp)
	return c:IsSetCard(0x13f)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and Duel.IsExistingMatchingCard(c80621422.mfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,nil,c:GetAttribute())
end
function c80621422.mfilter(c,attr)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsAttribute(attr)
end
function c80621422.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80621422.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c80621422.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c80621422.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if not tc then return end
	if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	local ec=e:GetLabelObject()
	if not ec:IsRelateToEffect(e) then return end
	Duel.BreakEffect()
	if not Duel.Equip(tp,ec,tc,false) then return end
	--Atk up
	local e1=Effect.CreateEffect(ec)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(500)
	ec:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	e2:SetLabelObject(tc)
	e2:SetValue(c80621422.eqlimit2)
	ec:RegisterEffect(e2)
end
function c80621422.eqlimit2(e,c)
	return c==e:GetLabelObject()
end
