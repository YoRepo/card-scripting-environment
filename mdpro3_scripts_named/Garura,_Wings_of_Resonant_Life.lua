--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 共命之翼 迦楼罗  (ID: 11765832)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Winged Beast
-- Level 6
-- ATK 1500 | DEF 2400
--
-- Effect Text:
-- 相同种族·属性而卡名不同的怪兽×2
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的战斗发生的对对方的战斗伤害变成2倍。
-- ②：这张卡被送去墓地的场合才能发动。自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--共命の翼ガルーラ
function c11765832.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c11765832.ffilter,2,true)
	--double damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11765832,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,11765832)
	e2:SetTarget(c11765832.target)
	e2:SetOperation(c11765832.operation)
	c:RegisterEffect(e2)
end
function c11765832.matchfilter(c,attr,race)
	return c:IsFusionAttribute(attr) and c:IsRace(race)
end
function c11765832.ffilter(c,fc,sub,mg,sg)
	return not sg or sg:FilterCount(aux.TRUE,c)==0
		or (sg:IsExists(c11765832.matchfilter,#sg-1,c,c:GetFusionAttribute(),c:GetRace())
			and not sg:IsExists(Card.IsFusionCode,1,c,c:GetFusionCode()))
end
function c11765832.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c11765832.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
