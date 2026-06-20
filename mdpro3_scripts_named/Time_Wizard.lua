--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 时间魔术师  (ID: 71625222)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 2
-- ATK 500 | DEF 400
-- Setcode: 152
--
-- Effect Text:
-- ①：1回合1次，自己主要阶段才能发动。进行1次投掷硬币，对里表作猜测。猜中的场合，对方场上的怪兽全部破坏。猜错的场合，自己场上的怪兽全部破坏，自己受到表侧表示破坏的怪兽的攻击力合计数值一半的伤害。
--[[ __CARD_HEADER_END__ ]]

--時の魔術師
function c71625222.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71625222,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c71625222.destg)
	e1:SetOperation(c71625222.desop)
	c:RegisterEffect(e1)
end
function c71625222.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	if #g>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	end
end
function c71625222.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local coin=Duel.AnnounceCoin(tp)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+71625222,e,0,0,tp,0)
	else
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(g,REASON_EFFECT)
		local dg=Duel.GetOperatedGroup()
		local sum=0
		for c in aux.Next(dg) do
			sum=sum+math.max(c:GetAttack(),0)
		end
		if sum>0 then
			Duel.Damage(tp,math.floor(sum/2),REASON_EFFECT)
		end
	end
end
