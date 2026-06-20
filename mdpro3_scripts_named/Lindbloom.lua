--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 龙胆花鳞虫  (ID: 52339733)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Wyrm
-- Level 4
-- ATK 0 | DEF 1800
--
-- Effect Text:
-- ①：这张卡在怪兽区域存在，自己怪兽和对方怪兽进行战斗的伤害计算时发动。直到伤害步骤结束时，进行战斗的各自怪兽的攻击力变成和各自守备力相同数值。
--[[ __CARD_HEADER_END__ ]]

--竜胆ブルーム
function c52339733.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c52339733.atkcon)
	e1:SetOperation(c52339733.atkop)
	c:RegisterEffect(e1)
end
function c52339733.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:GetControler()~=d:GetControler()
		and (a:IsDefenseAbove(0) or d:IsDefenseAbove(0))
end
function c52339733.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsFaceup() and a:IsRelateToBattle() and d:IsFaceup() and d:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		if a:IsDefenseAbove(0) then
			e1:SetValue(a:GetDefense())
			a:RegisterEffect(e1)
		end
		if d:IsDefenseAbove(0) then
			local e2=e1:Clone()
			e2:SetValue(d:GetDefense())
			d:RegisterEffect(e2)
		end
	end
end
