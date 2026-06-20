--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 异色眼龙  (ID: 53025096)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 153
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽送去墓地的场合发动。给与对方那只怪兽的原本攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--オッドアイズ・ドラゴン
function c53025096.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53025096,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c53025096.damcon)
	e1:SetTarget(c53025096.damtg)
	e1:SetOperation(c53025096.damop)
	c:RegisterEffect(e1)
end
function c53025096.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c53025096.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	local dam=math.floor(bc:GetBaseAttack()/2)
	Duel.SetTargetCard(bc)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c53025096.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local dam=math.floor(tc:GetBaseAttack()/2)
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end
