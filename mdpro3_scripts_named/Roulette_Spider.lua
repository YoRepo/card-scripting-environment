--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Roulette Spider  (ID: 36708764)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack: Roll a six-sided die and apply the result.
-- 1: Halve your LP.
-- 2: Make that attack a direct attack.
-- 3: Choose 1 monster you control, change the attack target to it, and perform damage calculation.
-- 4: Choose 1 other monster your opponent controls, change the attack target to it, and perform damage
-- calculation.
-- 5: Negate the attack, and if you do, inflict damage to your opponent equal to that monster's ATK.
-- 6: Destroy that opponent's monster.
--[[ __CARD_HEADER_END__ ]]

--ルーレット・スパイダー
function c36708764.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE+CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c36708764.condition)
	e1:SetTarget(c36708764.target)
	e1:SetOperation(c36708764.activate)
	c:RegisterEffect(e1)
end
function c36708764.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c36708764.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local at=Duel.GetAttacker()
	Duel.SetTargetCard(at)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c36708764.activate(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.TossDice(tp,1)
	if dc==1 then
		local lp=Duel.GetLP(tp)
		Duel.SetLP(tp,math.ceil(lp/2))
		return
	elseif dc==2 then
		Duel.ChangeAttackTarget(nil)
		return
	elseif dc==3 then
		local bc=Duel.GetAttackTarget()
		local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,bc)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(36708764,0))
			local tc=g:Select(tp,1,1,nil):GetFirst()
			local at=Duel.GetAttacker()
			if at:IsAttackable() and not at:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then
				Duel.CalculateDamage(at,tc)
			end
		end
		return
	elseif dc==4 then
		local at=Duel.GetAttacker()
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,at)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(36708764,0))
			local tc=g:Select(tp,1,1,nil):GetFirst()
			local at=Duel.GetAttacker()
			if at:IsAttackable() and not at:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then
				Duel.CalculateDamage(at,tc)
			end
		end
		return
	elseif dc==5 then
		local at=Duel.GetFirstTarget()
		if at:IsRelateToEffect(e) and Duel.NegateAttack() and at:GetAttack()>0 then
			Duel.Damage(1-tp,at:GetAttack(),REASON_EFFECT)
		end
		return
	elseif dc==6 then
		local at=Duel.GetFirstTarget()
		if at:IsRelateToEffect(e) and at:IsControler(1-tp) and at:IsType(TYPE_MONSTER) then
			Duel.Destroy(at,REASON_EFFECT)
		end
	end
end
