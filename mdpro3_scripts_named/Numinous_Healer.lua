--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 白衣天使  (ID: 2130625)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己因战斗或者卡的效果受到伤害时才能发动。自己回复1000基本分。自己墓地有「白衣天使」存在的场合，再回复那个数量的500基本分。
--[[ __CARD_HEADER_END__ ]]

--白衣の天使
function c2130625.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c2130625.reccon)
	e1:SetTarget(c2130625.rectg)
	e1:SetOperation(c2130625.recop)
	c:RegisterEffect(e1)
end
function c2130625.reccon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c2130625.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c2130625.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
	local gc=Duel.GetMatchingGroupCount(Card.IsCode,p,LOCATION_GRAVE,0,nil,2130625)
	if gc>0 then
		Duel.Recover(p,500*gc,REASON_EFFECT)
	end
end
