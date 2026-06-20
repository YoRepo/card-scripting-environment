--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 破灭的仪式  (ID: 52913738)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「破灭之魔王 加兰道夫」的降临必需。必须从手卡·自己场上把等级合计直到7以上的怪兽解放。可以把自己墓地存在的这张卡从游戏中除外，这个回合自己场上表侧表示存在的仪式怪兽战斗破坏的怪兽不送去墓地回到卡组最
-- 上面。
--[[ __CARD_HEADER_END__ ]]

--破滅の儀式
function c52913738.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,30646525)
	--To Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52913738,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c52913738.regcon)
	e1:SetCost(aux.bfgcost)
	e1:SetOperation(c52913738.regop)
	c:RegisterEffect(e1)
end
function c52913738.regcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c52913738.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_RITUAL))
	e1:SetValue(LOCATION_DECK)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
