--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暗黑之宝箱怪 LV3  (ID: 1102515)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 65
--
-- Effect Text:
-- 这张卡因为战斗送去墓地的场合，这张卡的控制者从卡组抽1张卡。这张卡因为「暗黑之宝箱怪 LV1」的效果特殊召唤的场合改成抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--暗黒のミミック LV3
function c1102515.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1102515,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c1102515.condition)
	e1:SetTarget(c1102515.target)
	e1:SetOperation(c1102515.operation)
	c:RegisterEffect(e1)
end
c1102515.lvup={74713516}
c1102515.lvdn={74713516}
function c1102515.condition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_LV then e:SetLabel(2)
	else e:SetLabel(1) end
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c1102515.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,e:GetLabel())
end
function c1102515.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
