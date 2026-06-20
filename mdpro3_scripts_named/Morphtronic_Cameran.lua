--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 变形斗士·照相机  (ID: 28124263)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 2
-- ATK 800 | DEF 600
-- Setcode: 38
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：这张卡被战斗破坏时，可以把自己的手卡·墓地存在的「变形斗士·照相机」以外的1只名字带有「变形斗士」的4星以下的怪兽在自己场上特殊召唤。
-- ●守备表示：只要这张卡在场上表侧表示存在，名字带有「变形斗士」的怪兽不能成为魔法·陷阱·效果怪兽的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--D・キャメラン
function c28124263.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_LEAVE_FIELD_P)
	e1:SetOperation(c28124263.check)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28124263,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c28124263.cona)
	e2:SetTarget(c28124263.tga)
	e2:SetOperation(c28124263.opa)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--untargetable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCondition(c28124263.cond)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x26))
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c28124263.check(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsDisabled() and c:IsAttackPos() then e:SetLabel(1)
	else e:SetLabel(0) end
end
function c28124263.cona(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==1
end
function c28124263.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x26) and not c:IsCode(28124263)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c28124263.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c28124263.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c28124263.opa(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c28124263.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
function c28124263.cond(e)
	return e:GetHandler():IsDefensePos()
end
