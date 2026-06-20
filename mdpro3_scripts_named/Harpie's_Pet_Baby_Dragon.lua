--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 鹰身女妖的宠物仔龙  (ID: 6924874)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 4
-- ATK 1200 | DEF 600
-- Setcode: 100
--
-- Effect Text:
-- 这张卡追加自己场上存在的除「鹰身女妖的宠物仔龙」以外的名字带有「鹰身」的怪兽的数量的效果。
-- ●1只：只要这张卡在场上表侧表示存在，对方不能选择自己场上存在的除「鹰身女妖的宠物仔龙」以外的名字带有「鹰身」的怪兽作为攻击对象。
-- ●2只：这张卡的原本攻击力·守备力变成2倍。
-- ●3只：1回合1次，可以把对方场上的1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ハーピィズペット仔竜
function c6924874.initial_effect(c)
	--at limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c6924874.atlimit)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetCondition(c6924874.adcon)
	e2:SetValue(c6924874.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_BASE_DEFENSE)
	e3:SetValue(c6924874.defval)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6924874,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCondition(c6924874.descon)
	e4:SetTarget(c6924874.destg)
	e4:SetOperation(c6924874.desop)
	c:RegisterEffect(e4)
end
function c6924874.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x64) and not c:IsCode(6924874)
end
function c6924874.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x64) and not c:IsCode(6924874)
end
function c6924874.adcon(e)
	return Duel.IsExistingMatchingCard(c6924874.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,2,nil)
end
function c6924874.atkval(e,c)
	return c:GetBaseAttack()*2
end
function c6924874.defval(e,c)
	return c:GetBaseDefense()*2
end
function c6924874.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c6924874.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,3,nil)
end
function c6924874.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c6924874.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
