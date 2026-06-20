--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 野蛮人国王  (ID: 39389320)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 3000 | DEF 1100
-- Setcode: 379
--
-- Effect Text:
-- ①：1回合1次，把这张卡以外的自己场上的战士族怪兽任意数量解放才能发动。这个回合，这张卡在同1次的战斗阶段中在通常攻击外加上可以作出最多有为这个效果发动而解放的怪兽数量的攻击。
--[[ __CARD_HEADER_END__ ]]

--バーバリアン・キング
function c39389320.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39389320,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c39389320.condition)
	e1:SetCost(c39389320.cost)
	e1:SetOperation(c39389320.operation)
	c:RegisterEffect(e1)
end
function c39389320.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c39389320.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,e:GetHandler(),RACE_WARRIOR) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,10,e:GetHandler(),RACE_WARRIOR)
	local ct=Duel.Release(g,REASON_COST)
	e:SetLabel(ct)
end
function c39389320.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
