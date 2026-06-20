--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 反射镜力龙  (ID: 84687358)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 2800 | DEF 1200
--
-- Effect Text:
-- 这张卡在用「克里底亚之牙」的效果把自己的手卡·场上的「神圣防护罩 -反射镜力-」送去墓地的场合才能特殊召唤。
-- ①：自己场上的怪兽被选择作为攻击对象时或者成为对方的效果的对象时才能发动。对方场上的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ミラーフォース・ドラゴン
function c84687358.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c84687358.descon1)
	e2:SetTarget(c84687358.destg)
	e2:SetOperation(c84687358.desop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_BECOME_TARGET)
	e3:SetCondition(c84687358.descon2)
	c:RegisterEffect(e3)
end
c84687358.material_trap=44095762
function c84687358.tgfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c84687358.descon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c84687358.tgfilter,1,nil,tp)
end
function c84687358.descon2(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and eg:IsExists(c84687358.tgfilter,1,nil,tp)
end
function c84687358.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c84687358.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
