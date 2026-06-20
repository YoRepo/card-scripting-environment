--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 新空间侠·海洋海豚  (ID: 78734254)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Warrior
-- Level 4
-- ATK 900 | DEF 1100
-- Setcode: 31
--
-- Effect Text:
-- 这个卡名在规则上也当作「新空间侠·水波海豚」使用。这张卡用「新空间侠界限」的效果才能特殊召唤。
-- ①：1回合1次，丢弃1张手卡才能发动。把对方手卡确认，从那之中选1只怪兽。持有选的怪兽的攻击力以上的攻击力的怪兽在自己场上存在的场合，选的怪兽破坏，给与对方500伤害。
--[[ __CARD_HEADER_END__ ]]

--N・マリン・ドルフィン
function c78734254.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78734254,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c78734254.cost)
	e2:SetTarget(c78734254.target)
	e2:SetOperation(c78734254.activate)
	c:RegisterEffect(e2)
	--add code
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_CODE)
	e4:SetValue(17955766)
	c:RegisterEffect(e4)
end
function c78734254.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c78734254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c78734254.filter(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk)
end
function c78734254.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(78734254,1))
		local tg=g:FilterSelect(tp,Card.IsType,1,1,nil,TYPE_MONSTER)
		local tc=tg:GetFirst()
		if tc then
			local atk=tc:GetAttack()
			if tc:IsAttackAbove(0) and Duel.IsExistingMatchingCard(c78734254.filter,tp,LOCATION_MZONE,0,1,nil,atk) then
				Duel.Destroy(tc,REASON_EFFECT)
				Duel.Damage(1-tp,500,REASON_EFFECT)
			end
		end
		Duel.ShuffleHand(1-tp)
	end
end
