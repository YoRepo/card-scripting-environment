--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 恶魔混沌王  (ID: 36407615)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 2600 | DEF 2600
-- Setcode: 13566021
--
-- Effect Text:
-- 恶魔族调整＋调整以外的怪兽1只以上
-- 这张卡的攻击宣言时，可以让对方场上表侧表示存在的全部怪兽的攻击力·守备力直到战斗阶段结束时交换。
--[[ __CARD_HEADER_END__ ]]

--デーモン・カオス・キング
function c36407615.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FIEND),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk/def swap
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36407615,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c36407615.attg)
	e1:SetOperation(c36407615.atop)
	c:RegisterEffect(e1)
end
function c36407615.filter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c36407615.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c36407615.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c36407615.atop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c36407615.filter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
