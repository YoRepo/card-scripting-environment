--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 爆翼龙  (ID: 40529384)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 2400 | DEF 1600
--
-- Effect Text:
-- 调整＋调整以外的龙族怪兽1只以上
-- 和持有这张卡的攻击力以下的攻击力的场上表侧表示存在的怪兽进行战斗的场合，可以不进行伤害计算把那只怪兽破坏，给与对方基本分破坏怪兽的攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--エクスプロード・ウィング・ドラゴン
function c40529384.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_DRAGON),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40529384,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c40529384.destg)
	e1:SetOperation(c40529384.desop)
	c:RegisterEffect(e1)
end
function c40529384.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc and tc:IsFaceup() and tc:GetAttack()<=c:GetAttack() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
end
function c40529384.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() and tc:GetAttack()<=c:GetAttack() then
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
