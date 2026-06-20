--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 幻煌龙的螺旋突  (ID: 48308134)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 250
--
-- Effect Text:
-- 通常怪兽才能装备。「幻煌龙的螺旋突」的②的效果1回合只能使用1次。
-- ①：装备怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- ②：装备怪兽给与对方战斗伤害时才能发动。从自己的手卡·卡组·墓地选1只「幻煌龙 螺旋」特殊召唤，这张卡给那只怪兽装备。那之后，可以选对方场上1只攻击表示怪兽变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--幻煌龍の螺旋突
function c48308134.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c48308134.target)
	e1:SetOperation(c48308134.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c48308134.eqlimit)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(48308134,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,48308134)
	e4:SetCondition(c48308134.spcon)
	e4:SetTarget(c48308134.sptg)
	e4:SetOperation(c48308134.spop)
	c:RegisterEffect(e4)
end
function c48308134.eqlimit(e,c)
	return c:IsType(TYPE_NORMAL)
end
function c48308134.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function c48308134.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c48308134.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c48308134.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c48308134.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c48308134.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c48308134.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst()==e:GetHandler():GetEquipTarget()
end
function c48308134.spfilter(c,e,tp)
	return c:IsCode(56649609) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48308134.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c48308134.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c48308134.posfilter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function c48308134.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c48308134.spfilter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			Duel.Equip(tp,c,tc)
			Duel.SpecialSummonComplete()
			local g=Duel.GetMatchingGroup(c48308134.posfilter,tp,0,LOCATION_MZONE,nil)
			if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(48308134,1)) then
				Duel.BreakEffect()
				local sg=g:Select(tp,1,1,nil)
				Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
			end
		end
	end
end
