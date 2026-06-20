--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 超重武者 兜-10  (ID: 41307269)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 2000
-- Setcode: 154
--
-- Effect Text:
-- ①：对方对怪兽的特殊召唤成功的场合才能发动。自己场上的攻击表示的「超重武者」怪兽全部变成守备表示，那个守备力直到回合结束时上升500。
--[[ __CARD_HEADER_END__ ]]

--超重武者カブ－10
function c41307269.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41307269,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c41307269.condition)
	e1:SetTarget(c41307269.target)
	e1:SetOperation(c41307269.operation)
	c:RegisterEffect(e1)
end
function c41307269.cfilter(c,tp)
	return c:IsSummonPlayer(1-tp)
end
function c41307269.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c41307269.cfilter,1,nil,tp)
end
function c41307269.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0x9a) and c:IsCanChangePosition()
end
function c41307269.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41307269.filter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c41307269.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c41307269.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c41307269.filter,tp,LOCATION_MZONE,0,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
	local og=Duel.GetOperatedGroup()
	local tc=og:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=og:GetNext()
	end
end
