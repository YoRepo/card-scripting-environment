--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 希望破坏炮  (ID: 30341772)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「希望皇 霍普」的怪兽存在的场合才能发动。对方场上1只攻击力最低的怪兽破坏，给与对方基本分破坏的怪兽的攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ホープ・バスター
function c30341772.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c30341772.condition)
	e1:SetTarget(c30341772.target)
	e1:SetOperation(c30341772.activate)
	c:RegisterEffect(e1)
end
function c30341772.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c30341772.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c30341772.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c30341772.filter(c)
	return c:IsFaceup()
end
function c30341772.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30341772.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c30341772.filter,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMinGroup(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tg:GetFirst():GetAttack())
end
function c30341772.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c30341772.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tc=nil
		local tg=g:GetMinGroup(Card.GetAttack)
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local sg=tg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			tc=sg:GetFirst()
		else
			tc=tg:GetFirst()
		end
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
