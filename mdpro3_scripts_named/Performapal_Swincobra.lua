--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 娱乐伙伴 秋千眼镜蛇  (ID: 93892436)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Reptile
-- Level 4
-- Pendulum Scales: L2 / R2
-- ATK 300 | DEF 1800
-- Setcode: 159
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，自己怪兽给与对方战斗伤害时才能发动。对方卡组最上面的卡送去墓地。
-- 【怪兽效果】
-- ①：这张卡可以直接攻击。
-- ②：这张卡攻击的场合，战斗阶段结束时变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--EMブランコブラ
function c93892436.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--deckdes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93892436,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c93892436.ddescon)
	e1:SetTarget(c93892436.ddestg)
	e1:SetOperation(c93892436.ddesop)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e2)
	--change position
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c93892436.poscon)
	e3:SetOperation(c93892436.posop)
	c:RegisterEffect(e3)
end
function c93892436.ddescon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():IsControler(tp)
end
function c93892436.ddestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,1)
end
function c93892436.ddesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
end
function c93892436.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c93892436.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
