--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 哥布林精英部队  (ID: 85306040)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 4
-- ATK 2200 | DEF 1500
-- Setcode: 172
--
-- Effect Text:
-- ①：这张卡攻击的场合，战斗阶段结束时变成守备表示，直到下次的自己回合的结束时不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--ゴブリンエリート部隊
function c85306040.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c85306040.poscon)
	e1:SetOperation(c85306040.posop)
	c:RegisterEffect(e1)
end
function c85306040.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c85306040.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,3)
	c:RegisterEffect(e1)
end
