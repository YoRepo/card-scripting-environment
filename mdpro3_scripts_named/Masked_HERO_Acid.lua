--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 假面英雄 酸水  (ID: 29095552)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Warrior
-- Level 8
-- ATK 2600 | DEF 2100
-- Setcode: 40968
--
-- Effect Text:
-- 这张卡用「假面变化」的效果才能特殊召唤。
-- ①：这张卡特殊召唤的场合发动。对方场上的魔法·陷阱卡全部破坏，对方场上的全部怪兽的攻击力下降300。
--[[ __CARD_HEADER_END__ ]]

--M・HERO アシッド
function c29095552.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.MaskChangeLimit)
	c:RegisterEffect(e1)
	--destrroy & atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29095552,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c29095552.destg)
	e2:SetOperation(c29095552.desop)
	c:RegisterEffect(e2)
end
function c29095552.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c29095552.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c29095552.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c29095552.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c29095552.filter,tp,0,LOCATION_ONFIELD,nil)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		local mg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local tc=mg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-300)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			tc=mg:GetNext()
		end
	end
end
