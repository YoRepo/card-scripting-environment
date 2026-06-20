--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 超念力枪手  (ID: 95526884)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Psychic
-- Level 9
-- ATK 3000 | DEF 2500
--
-- Effect Text:
-- 调整＋调整以外的念动力族怪兽1只以上
-- 这张卡攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。此外，这张卡向守备表示怪兽攻击的伤害步骤结束时，若攻击力超过那个守备力，自己基本分回复那个数值。
--[[ __CARD_HEADER_END__ ]]

--ハイパーサイコガンナー
function c95526884.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_PSYCHO),1)
	c:EnableReviveLimit()
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95526884,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c95526884.reccon)
	e2:SetTarget(c95526884.rectg)
	e2:SetOperation(c95526884.recop)
	c:RegisterEffect(e2)
end
function c95526884.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	local m=a:GetAttack()-d:GetDefense()
	e:SetLabel(m)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and c==a and d:GetDefense()>=0 and m>0 and bit.band(d:GetBattlePosition(),POS_DEFENSE)~=0
end
function c95526884.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabel())
end
function c95526884.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
