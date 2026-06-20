--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 断头台的惨剧  (ID: 35686187)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方场上表侧攻击表示存在的怪兽的表示形式变更为表侧守备表示时才能发动。对方场上守备表示存在的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--断頭台の惨劇
function c35686187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c35686187.condition)
	e1:SetTarget(c35686187.target)
	e1:SetOperation(c35686187.activate)
	c:RegisterEffect(e1)
end
function c35686187.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousPosition(POS_FACEUP_ATTACK) and c:IsPosition(POS_FACEUP_DEFENSE)
end
function c35686187.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c35686187.cfilter,1,nil,1-tp)
end
function c35686187.filter(c)
	return c:IsDefensePos()
end
function c35686187.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c35686187.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c35686187.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c35686187.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c35686187.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
