--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 黑羽-苍天之捷特  (ID: 87390067)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 1
-- ATK 100 | DEF 800
-- Setcode: 51
--
-- Effect Text:
-- 战斗伤害计算时，把这张卡从手卡送去墓地发动。自己场上存在的名字带有「黑羽」的怪兽不会被那次战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--BF－蒼天のジェット
function c87390067.initial_effect(c)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(87390067,0))
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c87390067.condition)
	e2:SetCost(c87390067.cost)
	e2:SetOperation(c87390067.operation)
	c:RegisterEffect(e2)
end
function c87390067.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	return (a:IsControler(tp) and a:IsSetCard(0x33))
		or (d:IsControler(tp) and d:IsSetCard(0x33))
end
function c87390067.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c87390067.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.GetTurnPlayer()~=tp then a=Duel.GetAttackTarget() end
	if not a:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(1)
	a:RegisterEffect(e1)
end
