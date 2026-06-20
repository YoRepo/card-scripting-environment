--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 禁止令  (ID: 43711255)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 宣言1个卡名才能把这张卡发动。
-- ①：只要这张卡在魔法与陷阱区域存在，宣言的卡名为原本卡名的双方的卡受以下所适用（对从这个效果的适用前开始在场上存在的卡不适用）。
-- ●不能在场上出现。
-- ●不能作卡的发动以及效果的发动和适用。
-- ●不能通常召唤·反转召唤·特殊召唤。
-- ●不能作攻击以及表示形式的变更。
-- ●不能作为要为需要素材的特殊召唤而用的素材。
--[[ __CARD_HEADER_END__ ]]

--禁止令
function c43711255.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c43711255.target)
	e1:SetOperation(c43711255.activate)
	c:RegisterEffect(e1)
end
function c43711255.bantg(e,c)
	local fcode=e:GetLabel()
	return c:IsOriginalCodeRule(fcode) and (not c:IsOnField() or c:GetRealFieldID()>e:GetFieldID())
end
function c43711255.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,0)
end
function c43711255.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	c:SetHint(CHINT_CARD,ac)
	--forbidden
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_FORBIDDEN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0xff,0xff)
	e2:SetTarget(c43711255.bantg)
	e2:SetLabel(ac)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
	Duel.AdjustInstantly(c)
end
