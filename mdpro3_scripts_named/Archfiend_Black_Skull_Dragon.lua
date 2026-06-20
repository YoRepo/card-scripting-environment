--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 恶魔龙 暗黑魔龙  (ID: 45349196)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 9
-- ATK 3200 | DEF 2500
-- Setcode: 69
--
-- Effect Text:
-- 6星「恶魔」通常怪兽＋「真红眼」通常怪兽
-- 自己对「恶魔龙 暗黑魔龙」1回合只能有1次特殊召唤。
-- ①：这张卡进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
-- ②：融合召唤的这张卡进行战斗的战斗阶段结束时，以自己墓地1只「真红眼」通常怪兽为对象才能发动。给与对方为墓地的那只怪兽的原本攻击力数值的伤害。那之后，那只怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--悪魔竜ブラック・デーモンズ・ドラゴン
function c45349196.initial_effect(c)
	c:SetSPSummonOnce(45349196)
	--fusion material
	aux.AddFusionProcFun2(c,c45349196.mfilter1,c45349196.mfilter2,true)
	c:EnableReviveLimit()
	--aclimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c45349196.accon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c45349196.damcon)
	e2:SetTarget(c45349196.damtg)
	e2:SetOperation(c45349196.damop)
	c:RegisterEffect(e2)
end
c45349196.material_setcode=0x3b
function c45349196.mfilter1(c)
	return c:IsFusionSetCard(0x45) and c:IsFusionType(TYPE_NORMAL) and c:IsLevel(6)
end
function c45349196.mfilter2(c)
	return c:IsFusionSetCard(0x3b) and c:IsFusionType(TYPE_NORMAL)
end
function c45349196.accon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c45349196.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_FUSION) and c:GetBattledGroupCount()>0
end
function c45349196.filter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_NORMAL) and c:IsAbleToDeck()
end
function c45349196.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c45349196.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c45349196.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c45349196.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g:GetFirst():GetBaseAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c45349196.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
