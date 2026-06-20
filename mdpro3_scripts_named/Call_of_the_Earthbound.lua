--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 地缚灵的引诱  (ID: 65743242)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 33
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时才能发动。那个攻击对象由自己重新选择。
--[[ __CARD_HEADER_END__ ]]

--地縛霊の誘い
function c65743242.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c65743242.condition)
	e1:SetTarget(c65743242.target)
	e1:SetOperation(c65743242.activate)
	c:RegisterEffect(e1)
end
function c65743242.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c65743242.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ag,da=eg:GetFirst():GetAttackableTarget()
		local at=Duel.GetAttackTarget()
		return ag:IsExists(aux.TRUE,1,at) or (at~=nil and da)
	end
end
function c65743242.activate(e,tp,eg,ep,ev,re,r,rp)
	local ag,da=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if da and at~=nil then
		local sel=0
		Duel.Hint(HINT_SELECTMSG,tp,31)
		if ag:IsExists(aux.TRUE,1,at) then
			sel=Duel.SelectOption(tp,1213,1214)
		else
			sel=Duel.SelectOption(tp,1213)
		end
		if sel==0 then
			Duel.ChangeAttackTarget(nil)
			return
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACKTARGET)
	local g=ag:Select(tp,1,1,at)
	local tc=g:GetFirst()
	if tc then
		Duel.ChangeAttackTarget(tc)
	end
end
