--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 巨大战舰 巨核  (ID: 14148099)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 6
-- ATK 2300 | DEF 1100
-- Setcode: 21
--
-- Effect Text:
-- 这张卡召唤时放置3个指示物。这张卡不会被战斗破坏。进行战斗的场合，伤害步骤终了时取除这张卡的1个指示物。没有指示物的状态下进行战斗的场合，伤害步骤终了时这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--巨大戦艦 ビッグ・コア
function c14148099.initial_effect(c)
	c:EnableCounterPermit(0x1f)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14148099,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c14148099.addct)
	e1:SetOperation(c14148099.addc)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--remove counter
	aux.EnableBESRemove(c)
end
function c14148099.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x1f)
end
function c14148099.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1f,3)
	end
end
