--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 龙影鱼 雷龙鳐  (ID: 43191636)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1500 | DEF 1000
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●这张卡的原本攻击力变成2300。这张卡攻击的场合，战斗阶段结束时变成守备表示。直到下次的自己回合结束时这张卡不能把表示形式改变。
--[[ __CARD_HEADER_END__ ]]

--竜影魚レイ・ブロント
function c43191636.initial_effect(c)
	aux.EnableDualAttribute(c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(2300)
	c:RegisterEffect(e1)
	--to defense
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c43191636.poscon)
	e2:SetOperation(c43191636.posop)
	c:RegisterEffect(e2)
end
function c43191636.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDualState() and e:GetHandler():GetAttackedCount()>0
end
function c43191636.posop(e,tp,eg,ep,ev,re,r,rp)
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
