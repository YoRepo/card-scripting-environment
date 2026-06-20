--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 伤害疫苗ΩMAX  (ID: 98535702)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己因战斗或者卡的效果受到伤害时才能发动。自己基本分回复自己受到的那次伤害的数值。
--[[ __CARD_HEADER_END__ ]]

--ダメージ・ワクチンΩMAX
function c98535702.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetTarget(c98535702.rectg)
	e1:SetOperation(c98535702.recop)
	c:RegisterEffect(e1)
end
function c98535702.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return ep==tp end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c98535702.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
