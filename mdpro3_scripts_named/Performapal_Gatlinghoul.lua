--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 娱乐伙伴 机炮食尸鬼  (ID: 49820233)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2900 | DEF 900
-- Setcode: 159
--
-- Effect Text:
-- 「娱乐伙伴」怪兽＋5星以上的暗属性怪兽
-- 「娱乐伙伴 机炮食尸鬼」的效果1回合只能使用1次。
-- ①：这张卡融合召唤成功的场合才能发动。给与对方为场上的卡数量×200伤害。这张卡用灵摆怪兽为素材作融合召唤的场合，再选对方场上1只怪兽破坏，给与对方那只怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--EMガトリングール
function c49820233.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f),aux.FilterBoolFunction(c49820233.ffilter),true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49820233,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,49820233)
	e1:SetCondition(c49820233.damcon)
	e1:SetTarget(c49820233.damtg)
	e1:SetOperation(c49820233.damop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c49820233.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c49820233.ffilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_DARK) and c:IsLevelAbove(5)
end
function c49820233.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c49820233.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)>0 end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
	if e:GetLabel()==1 then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c49820233.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if ct>0 and Duel.Damage(p,ct*200,REASON_EFFECT)>0 then
		if e:GetLabel()==1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
			if g:GetCount()>0 then
				Duel.BreakEffect()
				Duel.HintSelection(g)
				if Duel.Destroy(g,REASON_EFFECT)~=0 then
					local dam=g:GetFirst():GetBaseAttack()
					Duel.Damage(p,dam,REASON_EFFECT)
				end
			end
		end
	end
end
function c49820233.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsFusionType,1,nil,TYPE_PENDULUM) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
