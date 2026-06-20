--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 打落  (ID: 55773067)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方抽卡阶段时发动。对方的抽卡阶段抽的1张卡丢弃送去墓地。
--[[ __CARD_HEADER_END__ ]]

--はたき落とし
function c55773067.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_HANDES)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c55773067.condition)
	e1:SetTarget(c55773067.target)
	e1:SetOperation(c55773067.activate)
	c:RegisterEffect(e1)
end
function c55773067.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and bit.band(r,REASON_RULE)~=0
end
function c55773067.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c55773067.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==0 then
	elseif sg:GetCount()==1 then
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	else
		Duel.Hint(HINT_SELECTMSG,ep,HINTMSG_TOGRAVE)
		local dg=sg:Select(ep,1,1,nil)
		Duel.SendtoGrave(dg,REASON_EFFECT+REASON_DISCARD)
	end
end
