--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电子界量子龙  (ID: 63533837)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Cyberse
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 147
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：只要自己场上有连接怪兽存在，对方不能选择这张卡以外的自己场上的怪兽作为攻击对象，也不能作为效果的对象。
-- ②：1回合1次，这张卡和对方怪兽进行战斗的伤害步骤开始时才能发动。那只对方怪兽回到持有者手卡。这个效果发动的场合，这张卡只再1次可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--サイバース・クアンタム・ドラゴン
function c63533837.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--repeat attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63533837,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCountLimit(1)
	e1:SetTarget(c63533837.thtg)
	e1:SetOperation(c63533837.thop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c63533837.tgcon)
	e2:SetTarget(c63533837.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c63533837.tgcon)
	e3:SetValue(c63533837.tgtg)
	c:RegisterEffect(e3)
end
function c63533837.tgcon(e)
	return Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,TYPE_LINK)
end
function c63533837.tgtg(e,c)
	return c~=e:GetHandler()
end
function c63533837.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and tc:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
end
function c63533837.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if c==tc then tc=Duel.GetAttackTarget() end
	if tc and tc:IsRelateToBattle() then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
	if c:IsRelateToEffect(e) and c:IsChainAttackable() then
		Duel.ChainAttack()
	end
end
