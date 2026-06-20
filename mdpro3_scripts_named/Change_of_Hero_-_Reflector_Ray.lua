--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 英雄变化-反光体  (ID: 74095602)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上存在的名字带有「元素英雄」的融合怪兽被战斗破坏送去墓地时才能发动。给与对方基本分破坏的融合怪兽等级×300的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--英雄変化－リフレクター・レイ
function c74095602.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c74095602.condition)
	e1:SetTarget(c74095602.target)
	e1:SetOperation(c74095602.activate)
	c:RegisterEffect(e1)
end
function c74095602.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsPreviousControler(tp) and tc:IsType(TYPE_FUSION) and tc:IsSetCard(0x3008)
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
end
function c74095602.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=eg:GetFirst()
	local lv=tc:GetLevel()
	e:SetLabel(lv)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(lv*300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,lv*300)
end
function c74095602.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
