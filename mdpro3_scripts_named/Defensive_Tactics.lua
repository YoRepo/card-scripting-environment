--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 防守战术  (ID: 28877100)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上存在名字带有「剑斗兽」的怪兽场合才能发动，这回合内自己控制的怪兽不会被战斗破坏且自己受到的战斗伤害为0。这张卡回到自己卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--ディフェンシブ・タクティクス
function c28877100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c28877100.condition)
	e1:SetOperation(c28877100.activate)
	c:RegisterEffect(e1)
end
function c28877100.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1019)
end
function c28877100.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c28877100.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c28877100.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():CancelToGrave()
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
